Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161374AbWALWpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161374AbWALWpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161379AbWALWpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:45:25 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:15234 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1161374AbWALWpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:45:24 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades
To: linux-kernel@vger.kernel.org
Subject: Does a git pull have to be so big?
Date: Fri, 13 Jan 2006 08:45:29 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601130845.29797.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I try to do pulls reasonably often, but they always seem to be huge downloads 
- I'm sure they're orders of magnitude bigger than a simple patch would be. 
This leads me to ask, do they have to be so big? I'm on 256/64 ADSL at home, 
did a pull yesterday at work iirc, and yet the pull this morning has taken at 
least half an hour. Am I perhaps doing something wrong?

I'm using cogito .16-2 (ubuntu) and git 1.0.6.

Regards,

Nigel

#cg-fetch 
Fetching head...
Fetching objects...
progress: 114 objects, 256992 bytes
Getting alternates list for 
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
progress: 376 objects, 1413225 bytes
Getting pack list for 
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
progress: 453 objects, 1924312 bytes
Getting index for pack 221c50e73e5ab65afededc14f1df0541b59ebdd5
Getting pack 221c50e73e5ab65afededc14f1df0541b59ebdd5
 which contains 62727f8969438d99c3c34415d16611cf86f16140

(Still going)
