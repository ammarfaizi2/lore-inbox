Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130572AbQLEXyj>; Tue, 5 Dec 2000 18:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130399AbQLEXyc>; Tue, 5 Dec 2000 18:54:32 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:58638 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129210AbQLEXyF>; Tue, 5 Dec 2000 18:54:05 -0500
Date: Tue, 5 Dec 2000 17:18:59 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: Delaporte Frédéric <fredericdelaporte@free.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug Report : make modules_install seems to do a wrong call to depmod, using an unknow option "-F".
Message-ID: <20001205171859.C9642@vger.timpanogas.org>
In-Reply-To: <3A2D6C6E.5AC72B26@free.fr> <3A2D704B.941A65B1@haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A2D704B.941A65B1@haque.net>; from mhaque@haque.net on Tue, Dec 05, 2000 at 05:46:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 05:46:35PM -0500, Mohammad A. Haque wrote:
> Are you using the latest version of modutils?
> 
> Delaporte Frédéric wrote:
> > 
> > Hello.
> > 
> > make modules_install seems to do a wrong call to depmod, using an unknow
> > option "-F".

Upgrade your modutils.

Jeff

> 
> -- 
> 
> =====================================================================
> Mohammad A. Haque                              http://www.haque.net/ 
>                                                mhaque@haque.net
> 
>   "Alcohol and calculus don't mix.             Project Lead
>    Don't drink and derive." --Unknown          http://wm.themes.org/
>                                                batmanppc@themes.org
> =====================================================================
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
