Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWCWA60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWCWA60 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWCWA60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:58:26 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:55195 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932096AbWCWA6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:58:25 -0500
Message-ID: <4421F2AB.8010401@pobox.com>
Date: Wed, 22 Mar 2006 19:58:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Sergey Vlasov <vsu@altlinux.ru>, Geoff Rivell <grivell@comcast.net>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ahci: add softreset
References: <439CF812.8010107@pobox.com> <20060315191736.231a2894.vsu@altlinux.ru> <441F5C7D.2050600@pobox.com> <441FE146.3050406@gmail.com> <44202C4A.8030508@pobox.com> <20060322120703.GB23515@htj.dyndns.org>
In-Reply-To: <20060322120703.GB23515@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.6 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.6 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Now that libata is smart enought to handle both soft and hard resets,
> add softreset method.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


