Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVERUWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVERUWk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 16:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVERUWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 16:22:39 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:53733 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262338AbVERUUw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 16:20:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=fU34XJgyXK//aY3+s+ZgEYil9olX0576i6/3pRH2VumgryKEGKGkSWp7bBzkqVIw0vMALWHQDlUCZLZTWV294psflHT5k2JATHzkUrJubV3jPxwzDwZbpRt4DnFuDNCDVgccFQ7razrcyW0ScF1UNRq6PoS/AVNZZbRNb7ri3bc=
Date: Wed, 18 May 2005 22:20:44 +0200
From: Diego Calleja <diegocg@gmail.com>
To: YhLu <YhLu@tyan.com>
Cc: rminnich@lanl.gov, ebiederman@lnxi.com, stepan@openbios.org,
       ollie@lanl.gov, linuxbios@openbios.org, linux-tiny@selenic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Next step with LinuxBIOS
Message-Id: <20050518222044.2135e923.diegocg@gmail.com>
In-Reply-To: <3174569B9743D511922F00A0C943142309F80FE2@TYANWEB>
References: <3174569B9743D511922F00A0C943142309F80FE2@TYANWEB>
X-Mailer: Sylpheed version 1.9.11+svn (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 18 May 2005 12:42:31 -0700,
YhLu <YhLu@tyan.com> escribió:

> 3. smp ( i need apic...)

Why? Can't you use "Local APIC support on uniprocessors" (CONFIG_X86_UP_APIC)?
