Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVFAMfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVFAMfH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 08:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVFAMfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 08:35:07 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:5607 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261371AbVFAMdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 08:33:32 -0400
Message-ID: <429DAB07.1050900@anagramm.de>
Date: Wed, 01 Jun 2005 14:33:11 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Henk <Henk.Vergonet@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new 7-segments char translation API
References: <20050531220738.GA21775@god.dyndns.org>
In-Reply-To: <20050531220738.GA21775@god.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Henk!

> 1 - Notation
> 
> Make things potential interoperable, your character sets will be
> portable to other LCD devices.
> 
>    +-a-+
>    f   b
>    +-g-+   => encodes to =>  MSb  76543210 LSb
>    e   c                           gfedcba
>    +-d-+                     bit7 is reserved.
           (x)

Bit7 is propably useful for the decimal point (x)?
Well, that's how I used it some time ago.

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
