Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263088AbTCSRW1>; Wed, 19 Mar 2003 12:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263089AbTCSRW0>; Wed, 19 Mar 2003 12:22:26 -0500
Received: from realityfailure.org ([209.150.103.212]:25224 "EHLO
	bushido.realityfailure.org") by vger.kernel.org with ESMTP
	id <S263088AbTCSRWZ>; Wed, 19 Mar 2003 12:22:25 -0500
Date: Wed, 19 Mar 2003 12:33:09 -0500 (EST)
From: John Jasen <jjasen@realityfailure.org>
X-X-Sender: jjasen@bushido
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: "Richard B. Johnson" <johnson@quark.analogic.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Everything gone!
In-Reply-To: <Pine.LNX.4.53.0303191059140.31680@chaos>
Message-ID: <Pine.LNX.4.44.0303191232130.30655-100000@bushido>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, Richard B. Johnson wrote:

> Really? How did you do this?
> Clone my machine-name and domain, I mean? Without -bs in the
> header? I need to know. This could be exploited and needs
> to be fixed.

Perhaps:

telnet target.system 25
enter SMTP commands
quit

-- 
-- John E. Jasen (jjasen@realityfailure.org)
-- User Error #2361: Please insert coffee and try again.


