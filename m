Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289051AbSBDQUE>; Mon, 4 Feb 2002 11:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289056AbSBDQTy>; Mon, 4 Feb 2002 11:19:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50701 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289051AbSBDQTm>; Mon, 4 Feb 2002 11:19:42 -0500
Message-ID: <3C5EB491.5020001@zytor.com>
Date: Mon, 04 Feb 2002 08:19:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Marco Colombo <marco@esi.it>
CC: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <Pine.LNX.4.44.0202041051220.1381-100000@Megathlon.ESI>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Colombo wrote:

>>
>>No, the boot specification allows direct access to the CD.  See the El 
>>Torito specification, specifically the parts that talk about "no 
>>emulation" mode.
>>
> Is this the -hard-disk-boot option of mkisofs?
> 


No, it's -no-emul-boot

	-hpa


