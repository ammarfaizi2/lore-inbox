Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275094AbRJBPPx>; Tue, 2 Oct 2001 11:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275178AbRJBPPn>; Tue, 2 Oct 2001 11:15:43 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:1216 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S275094AbRJBPPe> convert rfc822-to-8bit; Tue, 2 Oct 2001 11:15:34 -0400
Date: 2 Oct 2001 15:29:45 -0000
Message-ID: <20011002152945.15180.qmail@mailweb16.rediffmail.com>
MIME-Version: 1.0
From: "Dinesh  Gandhewar" <dinesh_gandhewar@rediffmail.com>
Reply-To: "Dinesh  Gandhewar" <dinesh_gandhewar@rediffmail.com>
To: <mlist-linux-kernel@nntp-server.caltech.edu>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
I have written a linux kernel module. The linux version is 2.2.14. 
In this module I have declared an array of size 2048. If I use this array, the execution of this module function causes kernel to reboot. If I kmalloc() this array then execution of this module function doesnot cause any problem.
Can you explain this behaviour?
Thnaks,
Dinesh 
 

