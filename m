Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271122AbTHLVJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271125AbTHLVJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:09:47 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:65175
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271122AbTHLVJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:09:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Voluspa <lista1@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: WINE + Galciv + 2.6.0-test3-mm1-O15
Date: Wed, 13 Aug 2003 07:15:22 +1000
User-Agent: KMail/1.5.3
References: <20030812172358.5afe0cc1.lista1@telia.com>
In-Reply-To: <20030812172358.5afe0cc1.lista1@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308130715.23046.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003 01:23, Voluspa wrote:
> On 2003-08-12 14:42:02 gaxt wrote:
> Similar experience here running the game-test (xfree86 4.3.99.10, winex
> 3.1 and "Baldurs Gate I") on a PII 400 with 128 meg ram. Using
> 2.6.0-test3-O14.1int + O14.1-O15int.

Yes known issue for reason I mentioned. Currently investigating.

> I would say this is the best _and_ worst scheduler I've tried since Con

Can you give us some idea what your machine is like when it's not running a 
cpu hog win32 game in wine? Also can you try running your game nice +1

Con

