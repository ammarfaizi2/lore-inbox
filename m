Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbVKCBOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbVKCBOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 20:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbVKCBOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 20:14:04 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:29215 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030234AbVKCBOD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 20:14:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nst+VGHlEBqX4mgle9WNvVa6eK3wU3yxAfeyv/uknBYZb8CcA/LrjeI9uN4D3VmZs4SMdFWb/bCHlnacZporLK58Pd3cGSFAq4S2eNPOcBJtqqZuWxYkEqrC6BSxtNUEprj8cfC73LSiAsY74DouvAPxZ0+QPOgJnxiCoNqzPTg=
Message-ID: <39e6f6c70511021714m3023b686jcd7be2bb9ec9a3d3@mail.gmail.com>
Date: Wed, 2 Nov 2005 23:14:02 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Yan Zheng <yanzheng@21cn.com>
Subject: Re: [PATCH]A old patch for addrconf_ifdown(...).
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <43695E77.3080707@21cn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43695E77.3080707@21cn.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/05, Yan Zheng <yanzheng@21cn.com> wrote:
> Hi.
>
> The patch may be got lost. It's already acked by YOSHIFUJI.
>
>
> Signed-off-by: Yan Zheng<yanzheng@21cn.com>

I tought it had already been applied by Dave:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0510.1/1290.html

Anyway, applying it now, thanks.

- Arnaldo
