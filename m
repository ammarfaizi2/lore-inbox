Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbSAULhW>; Mon, 21 Jan 2002 06:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284890AbSAULhN>; Mon, 21 Jan 2002 06:37:13 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:11450 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S284794AbSAULhJ>; Mon, 21 Jan 2002 06:37:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Fabio Fracassi <turiya@linuxfromscratch.org>
Organization: Linux from Scratch
To: linux-kernel@vger.kernel.org
Subject: Complete lockup when using g++ on reiserfs
Date: Mon, 21 Jan 2002 12:41:02 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16Sckv-03IJKyC@fmrl01.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Please CC answers to me since I'm not subscribed here.

Since a while now I sometimes get  strange lockups when trying to compile
c++ programms. 
I cannot reproduce it exactly, but on larger c++ apps like Kde or Mozilla, 
the build hangs sooner or later.
I get this behavior with all kernels from  2.4.3  to 2.4.16 (haven't checked 
the newer ones yet)

The problem is that I cannot truely locate, where the error occurs, the logs 
are quite, and the system is truely dead (only HW reset works)

I first suspected my graphics HW (NVIDIA) to be causing the problems, but
the problems remain under Plain console, with no Drivers loaded.

The recent AMD/AGP Bug is also not causing it, I've checked that.

I suppose the Problem is somewhere in the ReiserFs part, since when this hang
happens the last processed c++ file sometimes gets corrupted.

If you need more Info on this please contact me, I'll try to give it then

I Hope someone can help me.

TIA 
Fabio Fracassi


