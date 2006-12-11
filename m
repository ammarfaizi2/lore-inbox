Return-Path: <linux-kernel-owner+w=401wt.eu-S1762445AbWLKE6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762445AbWLKE6F (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 23:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762448AbWLKE6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 23:58:05 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:58656 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762445AbWLKE6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 23:58:03 -0500
Message-ID: <457CE558.8030003@comcast.net>
Date: Sun, 10 Dec 2006 23:58:00 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PAE/NX without performance drain?
References: <200612102347_MC3-1-D49B-AB98@compuserve.com>
In-Reply-To: <200612102347_MC3-1-D49B-AB98@compuserve.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Chuck Ebbert wrote:
> In-Reply-To: <457B1F02.7030409@comcast.net>
> 
> On Sat, 09 Dec 2006 15:39:30 -0500, John Richard Moser wrote:
> 
>> Is it possible to give some other way to get the hardware NX bit working
>> in 32-bit mode, without the apparently massive performance penalty of
>> HIGHMEM64?
> 
> If your hardware can run the x86_64 kernel, try using that with your
> i386 userspace.  It works here...
> 

I hear that breaks USB printing.  Also I'm interested in getting it
working for other people, i.e. shipping with working NX.

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRXzlVgs1xW0HCTEFAQKGcQ//Q91/SNOSQQkRdOQLf6KAYfKbKSt5b9qm
EgpH7TdeJyFq+pZb90BKd0Sr7h245vr2q4+xufuZ51gxMIqc/+UZ6D0bttUbcE10
Pja/i0s3havWMccEs/60NqnM8xnV82IOUZORBPJKVoBo39pHBOGyRjkBJFjVOjQO
8baJN67fa1gTPxvnhS1Xb7LqxpJqGLygjCieofFxxLh7UJbvOVNoJLXyphMNA3AE
uwrut3HDLTPw7XW/klc1y8bFIOVf1RI9YLUiQZJPcyBTaEKntuFOzVbE1X1J5CDj
/96JE+oqqg+Y3ysyJY1kv7Rwo+zWAr/ARTcK+q9UlJXFabWDSb9WC6mS612YhISM
gus3P76oFZ27irVHHVlDKM6V9Uk7B2S5fZnjaiLV+yQ9IlxVInQohjn2aPpp+7Oj
zfWogpjjVMyWNnOdJ1PttvH2OCykNuMmE+YclsXt5GH8HobLlnOCBdfZYnH9hYmm
N//EoRC7HEX2mDcV0LwIhHiWOQxoPnhB3qDQnG1F/KNK7MYF9mpDtryoptDmu2y/
568V2sm/bx9JOKb7Dy5p2k8SAApUCnGZKVQ+JRJ7FxoIMpOZd5MVGy1cROroJW/x
LCuHNjm+tttMBuzn4R9LACp6QdNdW58ygbwzAL9HuHTeOtJjAVwdrvKOLjMCk23Q
qHv5gZB4NLs=
=ijVN
-----END PGP SIGNATURE-----
