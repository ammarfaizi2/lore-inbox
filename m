Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265026AbTGBOgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 10:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbTGBOgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 10:36:53 -0400
Received: from madrid10.amenworld.com ([217.174.194.138]:51728 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S265026AbTGBOgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 10:36:50 -0400
Date: Wed, 2 Jul 2003 16:51:27 +0200
From: DervishD <raul@pleyades.net>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slow writer...
Message-ID: <20030702145127.GB409@DervishD>
References: <5.1.0.14.2.20030702152720.00b01000@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5.1.0.14.2.20030702152720.00b01000@pop.t-online.de>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Margit :)

 * Margit Schubert-While <margitsw@t-online.de> dixit:
> http://www.cdrlabs.com/reviews/index.php?reviewid=185&page=Features
> It could be that "POWEREC" is biting you.

    Oh, I thought that the only thing that affected speed was the
VariRec (is that one that makes writing at 4x), and that must be
enabled explicitly. Thanks a lot, I will try to see if POWEREC is
giving me hell ;)) How can I get rid of POWEREC with cdrecord,
without needing to install the recorder on a WinDOS?

    BTW, the POWEREC issue makes sense, since the writer will stop at
20x/16x (depending on what's being written, data/audio), but I'm
afraid that the only solution is using better quality media
(currently I'm using Traxdata, 40x capable, and a Plextor disk that
is supposed to be capable of 48x, maybe Plextor gives low quality
sample disks ;)))?) or disabling POWEREC (Windows only Plextools, I'm
afraid...) and take the risk...

    Thanks a lot for pointing this :))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
