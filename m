Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291452AbSBNLoF>; Thu, 14 Feb 2002 06:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291460AbSBNLn4>; Thu, 14 Feb 2002 06:43:56 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:40968 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S291452AbSBNLnj>; Thu, 14 Feb 2002 06:43:39 -0500
Date: Thu, 14 Feb 2002 12:43:35 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre9-mjc2
Message-ID: <20020214114335.GA4058@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <1013662709.6671.16.camel@ohdarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1013662709.6671.16.camel@ohdarn.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Michael Cohen wrote:

> 2.4.18-pre9-ac3				(Alan Cox et al)
...
> lm_sensors				(lm_sensors team)

Hum, the last time I merged that stuff into my own kernel, the
patch-generator that they ship did not include all of the drivers I
needed. Also, I'm missing i2c from your patch list. Is that intentional
or is the i2c patch not needed? Which lm_sensors version did you merge?

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
