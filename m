Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314562AbSDTFzo>; Sat, 20 Apr 2002 01:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314563AbSDTFzn>; Sat, 20 Apr 2002 01:55:43 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:22683 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S314562AbSDTFzm>;
	Sat, 20 Apr 2002 01:55:42 -0400
To: Elias <elias@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Generic HDLC layer] Frame Relay / CIR
In-Reply-To: <02041611300500.01020@elias.cyclades.com.br>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Apr 2002 23:28:21 +0200
Message-ID: <m34ri8n1ca.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Elias <elias@cyclades.com> writes:

> 	I'm start to implement CIR feature for the Frame-Relay  of the
> Generic HDLC 
> layer.

Ok.

BTW: What exactly do you want to implement? Outbound rate limiting on
congested PVCs? Or *ECN signaling and CIR/EIR enforcing?
-- 
Krzysztof Halasa
Network Administrator
