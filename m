Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVDTTmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVDTTmH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 15:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVDTTmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 15:42:07 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:59566 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261692AbVDTTmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 15:42:05 -0400
Message-ID: <4266B087.4020307@lsrfire.ath.cx>
Date: Wed, 20 Apr 2005 21:41:59 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] procfs privacy: tasks/processes lookup
References: <1113849993.17341.69.camel@localhost.localdomain>
In-Reply-To: <1113849993.17341.69.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Hernández García-Hierro schrieb:
> This patch restricts non-root users to view only their own processes.

You may also want to have a look at the patches I submitted over the
last few weeks that restricted some file permissions in /proc/<pid>/ and
the comments I received.

Regards,
Rene
