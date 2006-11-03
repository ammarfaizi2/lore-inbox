Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWKCUtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWKCUtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWKCUtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:49:13 -0500
Received: from mx.pathscale.com ([64.160.42.68]:8410 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932126AbWKCUtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:49:02 -0500
Message-ID: <454BAB43.7010305@pathscale.com>
Date: Fri, 03 Nov 2006 12:49:07 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: olson@pathscale.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] htirq: Refactor so we only have one function that
 writes to the chip.
References: <454A7B0F.7060701@pathscale.com>	<m1odrpymqc.fsf@ebiederm.dsl.xmission.com>	<454B7B70.9060104@pathscale.com>	<m1d584xutk.fsf@ebiederm.dsl.xmission.com>	<454B880A.1010802@pathscale.com>	<m1zmb8wexd.fsf@ebiederm.dsl.xmission.com>	<454B8E19.90300@pathscale.com>	<m1irhww9f9.fsf_-_@ebiederm.dsl.xmission.com> <m1ejskw9as.fsf_-_@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ejskw9as.fsf_-_@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Acked-by: Bryan O'Sullivan <bos@pathscale.com>
