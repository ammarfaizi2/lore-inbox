Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSFUQEC>; Fri, 21 Jun 2002 12:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSFUQEB>; Fri, 21 Jun 2002 12:04:01 -0400
Received: from a238-141.dialup.iol.cz ([194.228.141.238]:23304 "EHLO devix")
	by vger.kernel.org with ESMTP id <S316659AbSFUQEB>;
	Fri, 21 Jun 2002 12:04:01 -0400
Date: Fri, 21 Jun 2002 17:12:05 +0200 (CEST)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.22 ide disk hang on boot
In-Reply-To: <3D1335AC.6080100@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0206211625520.1049-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Huh, how fast .. I even didn't notice there is 2.5.24 :)
Now it seems to work. Thanks. Only in case it is interesting
to you the "Use old disk-only driver on primary interface"
seeting is not working. When I user it the kernel hung up
just after Freeing unused kernel memory: 192k freed
message.

regards,
devik

On Fri, 21 Jun 2002, Martin Dalecki wrote:

> > Please can you tell me where to find the ide-clean-92.diff ?
> >
> Please go ahead to 2.5.24, it could help it.

