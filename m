Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTLXRXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 12:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263758AbTLXRXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 12:23:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:32207 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263742AbTLXRXL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 12:23:11 -0500
To: Sven K=?iso-8859-15?q?=F6?=hler <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: allow process or user to listen on priviledged ports?
References: <bscg1m$1eg$1@sea.gmane.org>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Wed, 24 Dec 2003 18:23:07 +0100
Message-ID: <87oetynn9g.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Köhler <skoehler@upb.de> writes:

> my problem is, that i want an application to listen on a priviledged
> port (e.g. port 80) and to run as a "normal" unpriviledged user
>
> So is there any machanism to bind that permission (to listen on a
> priviledged tcp-port) to a specific user or a specific process?

Of course, there is :-)
<http://www.olafdietsche.de/linux/accessfs/>

Regards, Olaf.
