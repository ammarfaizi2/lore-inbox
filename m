Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263323AbTDGIG2 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbTDGIG2 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:06:28 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:29191 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S263323AbTDGIG0 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 04:06:26 -0400
Date: Mon, 7 Apr 2003 10:18:00 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
Message-ID: <20030407081800.GA48052@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org> <b6qruf$elf$1@cesium.transmeta.com> <b6r9cv$jof$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6r9cv$jof$1@news.cistron.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 07:29:35AM +0000, Miquel van Smoorenburg wrote:
> Can't you just check those permissions, i.e. behave like link() ?
> If you cant't access the path to the file, don't permit flink() ?

Which path ?  A file can have many paths to it, or to the other
extreme none at all.

  OG.
