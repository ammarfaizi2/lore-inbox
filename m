Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWEANgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWEANgd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 09:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWEANgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 09:36:32 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:52662 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932092AbWEANgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 09:36:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=j0FgV3sGrMbYc5u3+I/U/cC58SZuJxLvj3qeo164EayTrXeln09Iu5vUPfkIgJms7ff8ROmzLw7A95P02yWI9lNyjoQjqoL57LVAPg1h+e8Z2wyv8Q8pv62BT0CZCUzGOHQ9SdnH2dvtwNAVE6E2++Cbom9FgfD95qkMuRm/Io8=
Message-ID: <44560EB8.1040006@gmail.com>
Date: Mon, 01 May 2006 15:35:52 +0200
From: jordi Vaquero <jordi.vaquero@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060309)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: encrypt data
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm making a kernel module. In a part of this module I'm trying to
encrypt a data buffer. Do you know how can I do it in kernel mode???
Is there some equivalent of the crypt function of the C library?.
thanks in advanced.
jordi
