Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUJFEcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUJFEcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 00:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUJFEcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 00:32:39 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:58015 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267180AbUJFEch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 00:32:37 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PS2 mouse/kbd problems
Date: Tue, 5 Oct 2004 23:32:34 -0500
User-Agent: KMail/1.6.2
Cc: "J.A. Magallon" <jamagallon@able.es>, Andrew Morton <akpm@osdl.org>
References: <1096998302l.5347l.0l@werewolf.able.es>
In-Reply-To: <1096998302l.5347l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410052332.34837.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 October 2004 12:45 pm, J.A. Magallon wrote:
> Hi all...
> 
> I got time to track my ps2 problems. I run 2.6.9-rc2-mm[123] (that was
> enough).
> 
> Results:
> - mm1: mouse and kbd work ok, both in console and X
> - mm2: mouse works, no kbd. I had to unplug/plug the keyboard to get it
>   responding.
> - mm3: kbd ok, but ps2 mouse is sluggish.
> 
> In latest -rc3-mm2, behavior is like mm3 and above.
> 

What about vanilla -rc3 and vanilla -rc3 with bk-input patch applied (if you
have some time of course). Do they exibit the same symptoms as -mm tree?

-- 
Dmitry
