Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282838AbRLLWfg>; Wed, 12 Dec 2001 17:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282817AbRLLWfR>; Wed, 12 Dec 2001 17:35:17 -0500
Received: from ulima.unil.ch ([130.223.144.143]:2176 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S282838AbRLLWez>;
	Wed, 12 Dec 2001 17:34:55 -0500
Date: Wed, 12 Dec 2001 23:34:53 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: tech_info@vmware.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer dereference at virtual address 00000004 (VMWARE,2.4.16 and 2.4.17-pre7)
Message-ID: <20011212233453.A3795@ulima.unil.ch>
In-Reply-To: <20011210164505.A3770@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011210164505.A3770@ulima.unil.ch>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 04:45:05PM +0100, Gregoire Favre wrote:
> Hello,
> 
> I try to use VMWARE 3.0 under 2.4.16 and had problems, so I try under
> 2.4.17-pre7, with same results:
> 
> ble to handle kernel NULL pointer dereference at virtual address 00000004
> ...

Shame on me: I compiled my kernel with gcc (which is 3.02) and
vmware-config.pl take kgcc (if I have well understood) as default, which
wasn't working that good...

Sorry, now I could try vmware ;-)

Thanks,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
