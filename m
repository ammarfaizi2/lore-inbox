Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbTBCXuo>; Mon, 3 Feb 2003 18:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbTBCXuo>; Mon, 3 Feb 2003 18:50:44 -0500
Received: from mailf.telia.com ([194.22.194.25]:18134 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S267049AbTBCXum> convert rfc822-to-8bit;
	Mon, 3 Feb 2003 18:50:42 -0500
X-Original-Recipient: <linux-kernel@vger.kernel.org>
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Compactflash cards dying?
Date: Tue, 4 Feb 2003 00:56:00 +0100
User-Agent: KMail/1.5.9
References: <20030202223009.GA344@elf.ucw.cz>
In-Reply-To: <20030202223009.GA344@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200302040056.02287.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 February 2003 23:30, Pavel Machek wrote:
> Hi!
> 
> I had compactflash from Apacer (256MB), and it started corrupting data
> in few months, eventually becoming useless and being given back for
> repair. They gave me another one and it is just starting to corrupt
> data.
> 
> First time I repartitioned it; now I only did mke2fs, and data
> corruption can be seen by something as simple as
> 
> cat /mnt/cf/mp3/* > /mnt/cf/delme; md5sum /mnt/cf/delme.
> 
> [Fails 1 in 5 tries].

That is very bad... I wonder if you do something that the CF does
not like - like power off while writing (can actually destroy the
disk - read in some newsgroup)

> 
> Anyone seen something similar? Are there some known-good
> compactflash-es?
> 

I would recomend SanDisk

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

