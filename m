Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317833AbSHKIgz>; Sun, 11 Aug 2002 04:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317898AbSHKIgz>; Sun, 11 Aug 2002 04:36:55 -0400
Received: from rammstein.mweb.co.za ([196.2.53.175]:58850 "EHLO
	rammstein.mweb.co.za") by vger.kernel.org with ESMTP
	id <S317833AbSHKIgy>; Sun, 11 Aug 2002 04:36:54 -0400
Message-ID: <3D5622FC.7080602@netactive.co.za>
Date: Sun, 11 Aug 2002 10:40:28 +0200
From: Chris the Elder <chippo@netactive.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ancient NFS patch sought
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greets,

I'm looking for a few terms that I can use to STFW with google, to find
the patch (or code) for a wierd ancient NFS feature.

Many years ago I was using someone else's Linux box with NFS.  This
version of NFS had the feature that:

On the server you could copy a file to it's own name followed by a '#'
followed by the MAC address of one of the clients, and then that client
would see this copy of the file as though it were the original.  The two
files would typically be different, and the server and the client get
their own versions each.  The process could be continued for any number
of different clients.

Can anyone give me some search terms (or an URL) to help me find the
code for this feature on the web?

TIA,
chippo

PS: What I really want to know (which I'll hopefully glean from the
code/URL when located) is:
 - was this a user-space or kernel-space implementation of NFS
 - how much mission it'll be to get the same (or similar) functionality
on a 2.4 kern.

