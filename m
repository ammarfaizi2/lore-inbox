Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265524AbRFVVUh>; Fri, 22 Jun 2001 17:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265526AbRFVVU1>; Fri, 22 Jun 2001 17:20:27 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:7951 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S265524AbRFVVUH>; Fri, 22 Jun 2001 17:20:07 -0400
Date: Fri, 22 Jun 2001 16:19:57 -0500
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20010622170945.A16757@thyrsus.com>
In-Reply-To: <20010622160002.B16285@thyrsus.com> <Pine.LNX.4.33L.0106221753140.4442-100000@duckman.distro.conectiva> 
	<Pine.LNX.4.33L.0106221753140.4442-100000@duckman.distro.conectiva> 
	; from riel@conectiva.com.br on Fri, Jun 22, 2001 at 05:54:20PM -0300
Subject: Re: Maintainers master list?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <Ag1ABB.A.1QG._Z7M7@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from "Eric S. Raymond" <esr@thyrsus.com> on Fri, 22 Jun
2001 17:09:45 -0400


> What happens now when somebody takes over responsibility for a file
> or subsystem and the MAINTAINERS file doesn't get patched, either because
> that person forgets to send a MAINTAINERS update or Linus doesn't 
> happen to take the MAINTAINERS patch for a while?

Wouldn't this whole problem go away if the kernel source were stored in a
master CVS repository?  Maintainers would have write access to their respective
code, but only Linus and Alan would have delete access.  Everyone else would
have read-only access.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

