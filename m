Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031346AbWKVIzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031346AbWKVIzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 03:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031477AbWKVIzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 03:55:41 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:23877 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1031346AbWKVIzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 03:55:39 -0500
Message-ID: <45641E90.2000506@fr.ibm.com>
Date: Wed, 22 Nov 2006 10:55:28 +0100
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Dmitry Mishin <dim@openvz.org>
CC: Kirill Korotaev <dev@sw.ru>, Cedric Le Goater <clg@fr.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W. Biederman" <ebiederm@xmission.com>, netdev@vger.kernel.org
Subject: Re: [patch -mm] net namespace: empty framework
References: <4563007B.9010202@fr.ibm.com> <4563046B.6040909@sw.ru>	<45633EDF.3050309@fr.ibm.com> <200611221121.59322.dim@openvz.org>
In-Reply-To: <200611221121.59322.dim@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Mishin wrote:
> This patch looks acceptable for us.
> BTW, Daniel, we agreed to be based on the Andrey's patchset. I do not see a
> reason, why Cedric force us to make some unnecessary work and move existent
> patchset over his interface.

I still agree.
Don't blame Cedric, he just wanted to help us. BTW, it is not "his" 
interface but the namespace interface.

   -- Daniel



