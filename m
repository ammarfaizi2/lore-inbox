Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264161AbRFFVIM>; Wed, 6 Jun 2001 17:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264163AbRFFVIC>; Wed, 6 Jun 2001 17:08:02 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22288 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264161AbRFFVHv>; Wed, 6 Jun 2001 17:07:51 -0400
Subject: Re: temperature standard - global config option?
To: gurre@start.no (Harald Arnesen)
Date: Wed, 6 Jun 2001 22:05:41 +0100 (BST)
Cc: jamagallon@able.es (J . A . Magallon), alan@lxorguk.ukuu.org.uk (Alan Cox),
        davidw@apache.org (David N . Welton), linux-kernel@vger.kernel.org
In-Reply-To: <87d78hfhl9.fsf@basilikum.skogtun.com> from "Harald Arnesen" at Jun 06, 2001 11:01:38 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157kUn-0000Rd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Absolutely. We chide Microsoft for not following standards, so we
> should definitely follow the SI standards, which are much firmer than
> any internet standards.

/dev/temperature is in farenheit. It was specified by someone in the UK
several years ago and we are stuck with it that way really.

Newer API's should probably use celcius/kelvin

