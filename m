Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275423AbRJBPqD>; Tue, 2 Oct 2001 11:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275387AbRJBPpx>; Tue, 2 Oct 2001 11:45:53 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:5825 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S273709AbRJBPph> convert rfc822-to-8bit; Tue, 2 Oct 2001 11:45:37 -0400
Date: 2 Oct 2001 15:30:02 -0000
Message-ID: <20011002153002.15494.qmail@mailweb16.rediffmail.com>
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
 

