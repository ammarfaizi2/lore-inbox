Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbQLEXRS>; Tue, 5 Dec 2000 18:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbQLEXRI>; Tue, 5 Dec 2000 18:17:08 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:47857 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129485AbQLEXRD>; Tue, 5 Dec 2000 18:17:03 -0500
Message-ID: <3A2D704B.941A65B1@haque.net>
Date: Tue, 05 Dec 2000 17:46:35 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Delaporte Frédéric 
	<fredericdelaporte@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug Report : make modules_install seems to do a wrong call to 
 depmod, using an unknow option "-F".
In-Reply-To: <3A2D6C6E.5AC72B26@free.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you using the latest version of modutils?

Delaporte Frédéric wrote:
> 
> Hello.
> 
> make modules_install seems to do a wrong call to depmod, using an unknow
> option "-F".

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
