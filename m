Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbTJ3KNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 05:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbTJ3KNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 05:13:44 -0500
Received: from spectre.fbab.net ([212.214.165.139]:29584 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id S262330AbTJ3KNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 05:13:42 -0500
Message-ID: <3FA0E44F.9040505@fbab.net>
Date: Thu, 30 Oct 2003 11:13:35 +0100
From: "Magnus Naeslund(t)" <mag@fbab.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sreeram Kumar Ravinoothala <sreeram.ravinoothala@wipro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question on SIGFPE
References: <94F20261551DC141B6B559DC4910867217764D@blr-m3-msg.wipro.com>
In-Reply-To: <94F20261551DC141B6B559DC4910867217764D@blr-m3-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sreeram Kumar Ravinoothala wrote:

> Hi,
> 	I am trying to run a multi threaded application on kernel 2.4.5.
> The application vanishes without leaving any trace (no core dump) when
> there is a link up on the hardware I use. If I try to debug I see the
> application being killed because of SIGFPE. Can anyone throw some light
> on this please? Also please cc the answer to me as I am not a member of
> the list.
 >

The most obvious thing is to check you code for a divide by zero error.

Magnus

