Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUCDQeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 11:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUCDQeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 11:34:13 -0500
Received: from mailout.zma.compaq.com ([161.114.64.104]:65295 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S262008AbUCDQeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 11:34:10 -0500
Message-ID: <40475A63.40909@digital.com>
Date: Thu, 04 Mar 2004 11:33:39 -0500
From: Aneesh Kumar KV <aneesh.kumar@digital.com>
User-Agent: Mozilla/5.0 (X11; U; OSF1 alpha; en-US; rv:1.4.1) Gecko/20031012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mru@kth.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alpha ptrace.c
References: <fa.cc73a44.1fjgqpi@ifi.uio.no> <fa.cg0ffsb.l402hh@ifi.uio.no>
In-Reply-To: <fa.cg0ffsb.l402hh@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> Aneesh Kumar KV <aneesh.kumar@digital.com> writes:
> 
> 
>>This patch was acknowledged by Richard
> 
> 
> And what is the purpose of it?
> 


I guess exit_code should be set before we wake_up the child.

-aneesh


