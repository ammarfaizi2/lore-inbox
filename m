Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277758AbRKFEKV>; Mon, 5 Nov 2001 23:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277798AbRKFEKL>; Mon, 5 Nov 2001 23:10:11 -0500
Received: from walden.phpwebhosting.com ([64.65.61.214]:50703 "HELO
	walden.phpwebhosting.com") by vger.kernel.org with SMTP
	id <S277758AbRKFEKG>; Mon, 5 Nov 2001 23:10:06 -0500
Message-Id: <5.1.0.14.0.20011105213158.009f05e0@sunset.olemiss.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 05 Nov 2001 22:09:55 -0600
To: linux-kernel@vger.kernel.org
From: Ben Pharr - Lists <ben-lists@benpharr.com>
Subject: Accessing CD-Writer Causes Freeze
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When accessing my CD Writer (/dev/scd0) in any way, my machine completely 
freezes. The reset button on the machine won't even turn it off. I have to 
pull the cord out of the back of the machine to get it to go off. This 
happens anytime I attempt to burn or mount a CD in this drive. It has been 
happening since about 2.4.9 and goes up through 2.4.14. I know 2.4.5 works, 
but I'm not sure about the status of the kernels between the two. No error 
messages are printed and no logs are written to. My CD burner is a Samsung 
SW-408B. I am running Debian Testing.

Ben Pharr
ben@benpharr.com

