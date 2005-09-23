Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVIWMh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVIWMh4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 08:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbVIWMh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 08:37:56 -0400
Received: from qproxy.gmail.com ([72.14.204.198]:18271 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750902AbVIWMhz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 08:37:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Dea/nqPiKzVn/XyDpjJAXOAqfNKlDhgxDz9O5HudPNNGJwRNAV/wFfGMKo91Asedqbh8PZNADxM6xcPLk2u9QfR+S//GiZ0cd2UBNj+AI9+bbK38ftPEyEh7lKb82rfB78k4LcCtAx12KuZQV2YwRsiOoiemYMWXNaIx4fjNQys=
Message-ID: <8518592505092305373465a5@mail.gmail.com>
Date: Fri, 23 Sep 2005 14:37:51 +0200
From: Pablo Fernandez <pablo.ferlop@gmail.com>
Reply-To: Pablo Fernandez <pablo.ferlop@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: max_fd
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

What happend to files_struct.max_fd? Is it safe to use
files_fdtable(files_struct).max_fds?

thanks,

Pablo Fernandez
