Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422822AbWJaIMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbWJaIMd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbWJaIMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:12:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:44782 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422822AbWJaIMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:12:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=t+h8CnfPNZD1xPNCFiiZsHeOfvKFGsAMrp7KZNwTw2JoWiIsQhKQs3Qwyqa/HEV9UuPAOGsss1I4qHTmfuSzIbxE4AfHrFGR9zNf+87TOzqXlGAuBmnTrP78tIQZOH+/cODafAoO630SESg8iBR02PPBO4H03N/pnIO0KAnO2kM=
Message-ID: <4547058D.9090607@innova-card.com>
Date: Tue, 31 Oct 2006 09:13:01 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 update4] drivers: add LCD support
References: <20061027153419.d98dbdd9.maxextreme@gmail.com>
In-Reply-To: <20061027153419.d98dbdd9.maxextreme@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda Sandonis wrote:
> Andrew, here it is the same patch without locking. Thanks you.

Last concern: did you think about cache aliasings ?

bye
		Franck

