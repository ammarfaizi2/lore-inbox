Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261580AbSJALdI>; Tue, 1 Oct 2002 07:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbSJALdI>; Tue, 1 Oct 2002 07:33:08 -0400
Received: from tbaytel3.tbaytel.net ([206.47.150.179]:41134 "EHLO tbaytel.net")
	by vger.kernel.org with ESMTP id <S261580AbSJALdH> convert rfc822-to-8bit;
	Tue, 1 Oct 2002 07:33:07 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Garrett Kajmowicz <garrett@tbaytel.net>
Reply-To: garrett@tbaytel.net
Organization: Garrett Kajmowicz
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE, TRIVIAL, RFC] Linux source strip/bundle script
Date: Tue, 1 Oct 2002 07:34:14 -0400
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210010734.14949.garrett@tbaytel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As per the suggestion of the lkml FAQ section 7-7, I have spent some time 
working on a script to automatically go through the Linux source tree and 
generate a stripped down version of the kernel source code (x86 only), along 
with a few additional 'modules' which will contain additional funtionality, 
if desired (such as irda or scsi support).

I have requested an account on kernel.org, and hope to run/test this script 
for each full, stable release.  I would like all of the input possible on the 
script.  Please note that this is the first version, so there are probably 
many rough areas.

For a copy of the script please try:

http://garrett.dyndns.biz/makemini.sh.bz2

Please Cc: all comments to:

Garrett Kajmowicz
gkajmowi@tbaytel.net

Thank you for your suggestions.
