Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263038AbTCSODG>; Wed, 19 Mar 2003 09:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263041AbTCSODG>; Wed, 19 Mar 2003 09:03:06 -0500
Received: from [64.76.155.81] ([64.76.155.81]:18304 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S263038AbTCSODE>;
	Wed, 19 Mar 2003 09:03:04 -0500
Date: Wed, 19 Mar 2003 10:13:57 -0400 (CLT)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: Andrus <andrus@members.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernels 2.2 and 2.4 exploit (ALL VERSION WHAT I HAVE TESTED
 UNTILL NOW!)
In-Reply-To: <000001c2ee1f$02da6820$0100a8c0@andrus>
Message-ID: <Pine.LNX.4.44.0303191012320.3319-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, Andrus wrote:
> You can download working exploit on
> http://www.members.ee/ptrace-exploit.c
> 
> Its hell long exploit as I know, and still not patched!
> 

I have it, it's no longer on that URL, but I test it against the last 
errata kernel from RedHat and it's not vulnerable.

[rmaureira@linux rmaureira]$ ./ptrace-xploit 
[-] Unable to attach: Operation not permitted
Killed

Best regards

-- 
Robinson Maureira Castillo
INACAP

