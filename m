Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754815AbWKIJee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbWKIJee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 04:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbWKIJed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 04:34:33 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:2717 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754815AbWKIJec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 04:34:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m2oJ/TIENZgEuN9GI5lJuPZj7UIi9TMU0MhoOgfoitigjOozX8UaI7/AGg+ECDAafeiChn0yIbHcZwDnA8tOwN3/tpOlIvFfdfMGeY17DiGMFTTqna9atppUyVCh0jdmvzN63YFl21ADhoDPBVIkec79mpyxSnXx/yKfpwLVkfo=
Message-ID: <3dd9a95e0611090134l74c181eemc1662e533b8e62d2@mail.gmail.com>
Date: Thu, 9 Nov 2006 17:34:30 +0800
From: gniuxiao <gniuxiao.mailinglist@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Why is there limited number of permanent memory mappings in kernel on x86?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So we have to use kmap() to map high memory to kernel address???
