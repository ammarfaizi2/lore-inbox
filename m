Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbSK1LmM>; Thu, 28 Nov 2002 06:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbSK1LmM>; Thu, 28 Nov 2002 06:42:12 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:39431 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S265211AbSK1LmL> convert rfc822-to-8bit; Thu, 28 Nov 2002 06:42:11 -0500
Date: Thu, 28 Nov 2002 12:49:29 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] NFS trouble - file corruptions
In-Reply-To: <Pine.LNX.4.44.0211280930530.1818-100000@grignard.amagerkollegiet.dk>
Message-ID: <Pine.LNX.4.44.0211281244570.1818-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2002, Rasmus Bøg Hansen wrote:

> On 27 Nov 2002, Trond Myklebust wrote:
>
> > >>>>> " " == Rasmus Bøg Hansen <moffe@amagerkollegiet.dk> writes:
> >
> >      > [1.] One line summary of the problem: Files created with
> >      > bzip2/gzip directly to NFS file system gets corrupted

> Both client and server now running 2.4.20-rc4, but unfortunately this
> does not solve the problem:

I just tried NFS over TCP and the problem occurs here too.

If I have understood TCP correctly, this should make sure, that this is
not a physical cabling error or data corruption in the NIC's...

/Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
I think the sum of intelligence on the internet is constant.
Only the number of users grows.
                                 - Uwe Ohse in the monastery
----------------------------------[ moffe at amagerkollegiet dot dk ] --

