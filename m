Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132855AbRDUTl2>; Sat, 21 Apr 2001 15:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132861AbRDUTlS>; Sat, 21 Apr 2001 15:41:18 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:38924 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132855AbRDUTlI> convert rfc822-to-8bit; Sat, 21 Apr 2001 15:41:08 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: "Tamas Nagy" <nagytam@rerecognition.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Idea: Encryption plugin architecture for file-systems
Date: Sat, 21 Apr 2001 21:40:47 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <NFBBIDPOFIIFCBDDFGLEGEMICCAA.nagytam@rerecognition.com>
In-Reply-To: <NFBBIDPOFIIFCBDDFGLEGEMICCAA.nagytam@rerecognition.com>
MIME-Version: 1.0
Message-Id: <01042121404701.08246@antares>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 April 2001 20:52, Tamas Nagy wrote:
> extend the current file-system with an optional plug-in system, which
> allows for file-system level encryption instead of file-level. This could
> be used transparently for applications or even for file-system drivers. 
> This doesn't mean an encrypted file-system, but a transparent encryption of
> a media instead.
> I suspect that this idea may appeared in the past:(, but I haven't heard
> about it;).
Not sure what you have in mind exactly, but there are related
projects:
 - the crypto modules in the international linux kernel
   (see http://encryptionhowto.sourceforge.net/Encryption-HOWTO.html)
 - Erik Zadok's FIST (http://www.cs.columbia.edu/~ezk/research/fist/)
 - the Transparent Cryptographic File System (http://www.tcfs.it/)
 - Stefan Ludwig's Fairly Secure File System 
  (http://osg.informatik.tu-chemnitz.de/publikat/da/00/Ludwig00.pdf,
   diploma thesis, in German)
 - Allan Latham's practical privacy disc (device) driver
   (http://linux01.gwdg.de/~alatham/ppdd.html)
 - Matt Blaze's CFS seems to be discontinued/unsupported
   (http://koeln.ccc.de/~drt/crypto/cfs-linux-HOWTO.txt)
Maybe you clarify what exactly you want to achieve/improve compared
to the existing projects.

Stefan J.

