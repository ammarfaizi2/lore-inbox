Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313307AbSDUNGD>; Sun, 21 Apr 2002 09:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313311AbSDUNGC>; Sun, 21 Apr 2002 09:06:02 -0400
Received: from ns.suse.de ([213.95.15.193]:50449 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313307AbSDUNGC>;
	Sun, 21 Apr 2002 09:06:02 -0400
Date: Sun, 21 Apr 2002 15:05:59 +0200
From: Dave Jones <davej@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Tigran Aivazian <tigran@veritas.com>, Michal Semler <cijoml@volny.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: Intel Speedstep technology switch
Message-ID: <20020421150559.J856@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Arjan van de Ven <arjanv@redhat.com>,
	Tigran Aivazian <tigran@veritas.com>,
	Michal Semler <cijoml@volny.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20020421105908.0B5ACAFA88@notas> <Pine.LNX.4.33.0204211242560.1662-100000@einstein.homenet> <20020421074930.A27740@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 07:49:30AM -0400, Arjan van de Ven wrote:
 > We're getting close.  Right now AMD K6+, K7 PowerNOW
 > (AMD speak for Speedstep) is supported, as well as Cyrix cpus. Intel
 > is lagging a bit due to Intel not giving
 > specs; but the reverse engineering is making progress on this part.

Yup, Dominik Brodowski has done quite a bit of work recently, and is
'almost there' with the newer style of speedstep. (The one used in ICH
chipsets), the older BX chipset style of speedstep still needs some
thinking.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
