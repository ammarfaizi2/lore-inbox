Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270134AbRIMMUs>; Thu, 13 Sep 2001 08:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270174AbRIMMU3>; Thu, 13 Sep 2001 08:20:29 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:36626 "EHLO
	anduin.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S270134AbRIMMUM>; Thu, 13 Sep 2001 08:20:12 -0400
Date: Thu, 13 Sep 2001 14:19:38 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: Stomping on Athlon bug
Message-ID: <20010913141937.A1873@gondor.com>
In-Reply-To: <17613305632.20010913121304@port.imtp.ilyichevsk.odessa.ua> <3BA087CA.3BD1D557@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA087CA.3BD1D557@redhat.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2001 at 11:17:46AM +0100, Arjan van de Ven wrote:
> Interesting; This is exactly the bit that the athlon cool thingy that
> popped up
> here a while ago changed; everybody agreed that it was WAAAAY too
> dangerous
> back then, because PSU's and voltage regulators wouldn't be able to
> cope......

But, as far as I understand, STPGNT will not be enabled unless ACPI
power saving is in use, so setting the disconnect on STPGNT bit should
not matter.

Jan

