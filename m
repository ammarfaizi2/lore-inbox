Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWAXThS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWAXThS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 14:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWAXThR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 14:37:17 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:33285 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S964895AbWAXThQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 14:37:16 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Benoit Boissinot <bboissin@gmail.com>
Subject: Re: Kernel 2.6.15 crashes X Server after running OpenGL programs
Date: Tue, 24 Jan 2006 19:37:06 +0000
User-Agent: KMail/1.9
Cc: Andy Spiegl <kernelbug.Andy@spiegl.de>, John Stoffel <john@stoffel.org>,
       linux-kernel@vger.kernel.org
References: <20060124121542.GB13646@spiegl.de> <20060124142151.GA3538@spiegl.de> <40f323d00601240713x26c3a04cra46e1cd9639b12f2@mail.gmail.com>
In-Reply-To: <40f323d00601240713x26c3a04cra46e1cd9639b12f2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601241937.06679.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 January 2006 15:13, Benoit Boissinot wrote:
> On 1/24/06, Andy Spiegl <kernelbug.Andy@spiegl.de> wrote:
> > Too bad there is no free OpenGL driver - I hate to use closed source
> > stuff.
>
> Radeon 9000 is supported in Xorg and as far as i know was already supported
> in Xfree86. The open-source driver works fine for me (Radeon 9200SE).

Indeed. Mesa will provide direct render acceleration on these cards without 
using the proprietary driver. Since the 9000 is really too old to run modern 
games, I suspect it will be more than adequate.

I'd investigate the open source solution, because ATI's proprietary driver is 
poor quality, even for your average binary vendor.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
