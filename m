Return-Path: <linux-kernel-owner+w=401wt.eu-S1752636AbWLSGVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbWLSGVw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbWLSGVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:21:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55678 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbWLSGVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:21:51 -0500
Message-ID: <458784EE.7080303@redhat.com>
Date: Mon, 18 Dec 2006 22:21:34 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [take28-resend_2->0 0/8] kevent: Generic event handling mechanism.
References: <11663636322861@2ka.mipt.ru> <458760C9.7080504@redhat.com> <20061219045130.GA28980@2ka.mipt.ru>
In-Reply-To: <20061219045130.GA28980@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> I've uploaded the latest changes to the homepage.

Thanks.  But could you now update the patch so that it can be compiled 
with the current upstream kernel?  At least <linux/kevent.h> has 
problems because of file->st accesses.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
