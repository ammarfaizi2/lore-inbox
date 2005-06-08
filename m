Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVFHXeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVFHXeo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 19:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVFHXeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:34:44 -0400
Received: from dvhart.com ([64.146.134.43]:46504 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261527AbVFHXel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:34:41 -0400
Date: Wed, 08 Jun 2005 16:34:37 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: apw@shadowen.org, pazke@donpac.ru, linux-kernel@vger.kernel.org, dev@sw.ru
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <1055500000.1118273677@flay>
In-Reply-To: <20050608162247.2c8f00f0.akpm@osdl.org>
References: <20050607042931.23f8f8e0.akpm@osdl.org><42A6FF41.5040109@shadowen.org><20050608130117.341fa4ff.akpm@osdl.org><1051200000.1118272473@flay> <20050608162247.2c8f00f0.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, June 08, 2005 16:22:47 -0700 Andrew Morton <akpm@osdl.org> wrote:

> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>> 
>> alt+sysrq+p does wierd stuff (is that new patch in your tree Andrew?
>>  doesn't seem to inter-react with the other NMI code well)
> 
> What patch?

Sorry.

nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch

It does seem to work. But probably needs some cleanup for the NMI
errors.



