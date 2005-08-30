Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbVH3OAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbVH3OAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVH3OAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:00:55 -0400
Received: from relay01.pair.com ([209.68.5.15]:55826 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1751426AbVH3OAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:00:54 -0400
X-pair-Authenticated: 67.187.99.138
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Philippe Elie <phil.el@wanadoo.fr>
Subject: Re: Second "CPU" of 1-core HyperThreading CPU not found in 2.6.13
Date: Tue, 30 Aug 2005 09:01:15 -0500
User-Agent: KMail/1.8.1
References: <200508292303.52735.chase.venters@clientec.com> <20050830122416.GD848@zaniah>
In-Reply-To: <20050830122416.GD848@zaniah>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508300901.15112.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I needed CONFIG_PM=y and CONFIG_ACPI=y to get ht working on 2.6.13.

CONFIG_ACPI and CONFIG_PM are enabled here.

Thanks,
Chase Venters
