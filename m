Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279378AbRJWLgM>; Tue, 23 Oct 2001 07:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279384AbRJWLgC>; Tue, 23 Oct 2001 07:36:02 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:54027 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S279380AbRJWLft>;
	Tue, 23 Oct 2001 07:35:49 -0400
Date: Tue, 23 Oct 2001 09:36:04 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Nicholas Knight <tegeran@home.com>, <drevil@warpcore.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
In-Reply-To: <20011022230631.A976@ftsoj.fsmlabs.com>
Message-ID: <Pine.LNX.4.33L.0110230935280.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001, Cort Dougan wrote:

> If the binary only module in question sticks with the "published
> interface" (as is required) isn't it a problem in Linux then?

1) there is no published interface, except in source code
2) we have no idea which parts of the code the nvidia
   driver "sticks with", since it's binary-only

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

