Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318065AbSGLXZS>; Fri, 12 Jul 2002 19:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318066AbSGLXZR>; Fri, 12 Jul 2002 19:25:17 -0400
Received: from pc132.utati.net ([216.143.22.132]:18565 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S318065AbSGLXZQ>; Fri, 12 Jul 2002 19:25:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: Re: No rule to make autoconf.h in 2.4.19-rc1?
Date: Fri, 12 Jul 2002 13:29:44 -0400
X-Mailer: KMail [version 1.3.1]
Cc: marcelo@conectiva.com.br
References: <20020712205136.8D3648B5@merlin.webofficenow.com>
In-Reply-To: <20020712205136.8D3648B5@merlin.webofficenow.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020712230735.EBAA98B5@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 July 2002 11:13 am, Rob Landley wrote:

> Maybe I'm doing something small and simple wrong (although 2.4.18 built),
> but I can't spot it.

I spotted it.

make oldconfig.

Sigh...

Rob
