Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272153AbTHNCtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 22:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272156AbTHNCtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 22:49:07 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:19883
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272153AbTHNCss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 22:48:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Wes Janzen <superchkn@sbcglobal.net>
Subject: Re: [PATCH]O15int for interactivity
Date: Thu, 14 Aug 2003 12:54:46 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308122226.11557.kernel@kolivas.org> <3F3AF781.2090007@sbcglobal.net>
In-Reply-To: <3F3AF781.2090007@sbcglobal.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308141254.46446.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003 12:44, Wes Janzen wrote:
> Earlier versions of your patch were smoother, but besides this problem,
> it's pretty good.

You're seeing the priority inversion problem that remains that others have 
felt in wine applications. Don't waste your time with different gcc 
compilations. I'm working on the problem.

Con

