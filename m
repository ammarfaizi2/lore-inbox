Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTJRAAv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 20:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263655AbTJRAAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 20:00:51 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:55301 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263653AbTJRAAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 20:00:50 -0400
Date: Sat, 18 Oct 2003 02:05:31 +0200
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Console escape sequences
Message-ID: <20031018000531.GB17198@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    Where should I look if I want to know which ANSI escape codes (or
any other escape codes) the console accepts? I know that I can send
ESC[1m; to the console for getting bold text, for example, and I know
more codes, extracted from the terminfo entries and places like that,
but I would like to know if somewhere in the sources is something
like a list of supported codes.

    Thanks a lot in advance.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
