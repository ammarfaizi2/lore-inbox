Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSHIXni>; Fri, 9 Aug 2002 19:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSHIXni>; Fri, 9 Aug 2002 19:43:38 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:38662 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316309AbSHIXnh>;
	Fri, 9 Aug 2002 19:43:37 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208092347.g79NlFF96768@saturn.cs.uml.edu>
Subject: Re: HFS cleanup #1 - remove partition code
To: oliver@neukum.name (Oliver Neukum)
Date: Fri, 9 Aug 2002 19:47:15 -0400 (EDT)
Cc: viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <200208100134.54011.oliver@neukum.name> from "Oliver Neukum" at Aug 10, 2002 01:34:53 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum writes:

> this removes the independent partition code from hfs.
> This is the first patch taking an axe to hfs so it'll be in shape for 2.6.
> Does anybody object to it being sent to Linus ?

I really hate to say it, but... yes. This is needed
for CD-ROMs.
