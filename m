Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277857AbRJIRUz>; Tue, 9 Oct 2001 13:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277856AbRJIRUp>; Tue, 9 Oct 2001 13:20:45 -0400
Received: from pD9E39FE4.dip.t-dialin.net ([217.227.159.228]:60545 "HELO
	pc1.geisel.info") by vger.kernel.org with SMTP id <S277855AbRJIRUf>;
	Tue, 9 Oct 2001 13:20:35 -0400
Date: Tue, 9 Oct 2001 19:20:53 +0200
From: Dominik Geisel <dominik@geisel.info>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with ACPI on Abit KT7,HPT370
Message-ID: <20011009192053.A2723@geisel.info>
In-Reply-To: <20011008201040.A1893@geisel.info> <XFMail.20011008223542.dominik@unix-ag.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20011008223542.dominik@unix-ag.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 2.4.10-ac10 with your config and played around with all possible
BIOS settings...the problem persists.

Also, I am now quite sure it broke with BIOS version 3R.


On Mon, Oct 08, 2001 at 10:35:42PM +0200, Dominik Thinay wrote:
> with kernel 2.4.11-pre3-xfs + i2c CVS-patch + lmsensors it works fine on my
> system (Abit Bios KT7_49B0)
> CONFIG_PM=y
> CONFIG_ACPI=y
> CONFIG_ACPI_DEBUG=y
> CONFIG_ACPI_BUSMGR=y
> CONFIG_ACPI_SYS=y
> CONFIG_ACPI_CPU=y
> CONFIG_ACPI_BUTTON=y
> 
> I remember disabled sth in the bios ...but i have forget ... :(
