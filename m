Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278446AbRJVJdk>; Mon, 22 Oct 2001 05:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278447AbRJVJdb>; Mon, 22 Oct 2001 05:33:31 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:12681 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S278446AbRJVJd1>; Mon, 22 Oct 2001 05:33:27 -0400
Date: Mon, 22 Oct 2001 11:33:53 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alram Lechner <a.lechner@htl-leonding.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Asus CUR-DLS (ServerWorks) SMP Hang up
Message-ID: <20011022113353.B720@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <01101609164500.28366@goliath.htl-leonding.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <01101609164500.28366@goliath.htl-leonding.ac.at>; from a.lechner@htl-leonding.ac.at on Tue, Oct 16, 2001 at 09:16:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2001 at 09:16:45AM +0200, Alram Lechner wrote:
> i have the following hardware:
> Asus CUR-DLS with ServerWorks Chip
> 2x P III 800 MHz
> 3x256 ECC RAM
> ATI Rage XL
> Symbios 53c1010
 
I have nearly the same. (just 2x512 ECC RAM and 2x PIII@850)

> and the followin problem:
> the system wil hang with two processors when i copy
> about 300 MB (files or one file) from one HDD to another.
> there is a complete hang up.

But I've only one HDD :-(

> is there anybody who has this board an can say it works with
> 2 cpu's?

It works for me. But I use it as an CPU-Server, so I don't need
many disks.

I had similiar behavior with an 2.4.2-ac20 and ftp, but this has
been a HIGHMEM related problem.

Regards

Ingo Oeser
