Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263103AbTCSRrl>; Wed, 19 Mar 2003 12:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263104AbTCSRrl>; Wed, 19 Mar 2003 12:47:41 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:43917 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S263103AbTCSRrk> convert rfc822-to-8bit; Wed, 19 Mar 2003 12:47:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: John Jasen <jjasen@realityfailure.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: Everything gone!
Date: Wed, 19 Mar 2003 11:55:06 -0600
User-Agent: KMail/1.4.1
Cc: "Richard B. Johnson" <johnson@quark.analogic.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303191232130.30655-100000@bushido>
In-Reply-To: <Pine.LNX.4.44.0303191232130.30655-100000@bushido>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303191155.06980.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 March 2003 11:33 am, John Jasen wrote:
> On Wed, 19 Mar 2003, Richard B. Johnson wrote:
> > Really? How did you do this?
> > Clone my machine-name and domain, I mean? Without -bs in the
> > header? I need to know. This could be exploited and needs
> > to be fixed.
>
> Perhaps:
>
> telnet target.system 25
> enter SMTP commands
> quit

Normaly that would record the IP of the host doing the telnet.
(the first "Recieved: from" line in the log list where the original says
"Received: from localhost"....)
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
