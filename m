Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVBNVF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVBNVF3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 16:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVBNVF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 16:05:29 -0500
Received: from hell.org.pl ([62.233.239.4]:48401 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261460AbVBNVF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 16:05:26 -0500
Date: Mon, 14 Feb 2005 22:05:28 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Romano Giannetti <romanol@upco.es>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Repost: BUG 2.6.11-rc1: ACPI keys events: only "arrive" after 8 of them.
Message-ID: <20050214210528.GA11884@hell.org.pl>
Mail-Followup-To: Romano Giannetti <romanol@upco.es>,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <20050214182112.GA11686@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20050214182112.GA11686@pern.dea.icai.upco.es>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Romano Giannetti:
>      I'm stymied. If anyone can help me with this, or simply tell me how to
>      have more data on this, I will try to obtain all the data I can. 
>      I'm using a vanilla 2.6.11-rc1, which config is available here: 

See http://bugme.osdl.org/show_bug.cgi?id=4124 -- sounds similar, but you
seem to experience some regularities that I think I ruled out in my case.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
