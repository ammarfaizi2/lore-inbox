Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbUKPPRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbUKPPRE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 10:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUKPPRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 10:17:04 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:62049 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262000AbUKPPRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 10:17:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qJCxpqo3QptFX7sRbYgDNwIQ1UoLRt3IfMeYUTGkQY0FqAItxtjs2S2hmaTl0/CnG2NdhmDrrmyAvcqo+U7yuL6mqDrg7Fgr14lwmjxZutaHUG2TDzoKIq2A/i+VA9NPA8MHpdDvRnvvfDoZTG9s1I/MabUwjxYWU8mEEaVFR1g=
Message-ID: <5b64f7f0411160717298bb576@mail.gmail.com>
Date: Tue, 16 Nov 2004 10:17:01 -0500
From: Rahul Karnik <deathdruid@gmail.com>
Reply-To: Rahul Karnik <deathdruid@gmail.com>
To: mile.davidovic@micronasnit.com
Subject: Re: ITERaid and atkbd
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200411161427.iAGERt46031185@krt.neobee.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411161427.iAGERt46031185@krt.neobee.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 15:23:30 +0100, Mile Davidovic
<mile.davidovic@micronasnit.com> wrote:
> Hi folks
> 
> I have trouble with IT8212F raid controller (on Gigabyte boards also known
> as GigaRaid) on FedoraCore 3.

Try the ac kernels. 

Arjan has some RPMs for FC3.

http://marc.theaimsgroup.com/?l=linux-kernel&m=110060681900689&w=2

-Rahul
