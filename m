Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbSKLONs>; Tue, 12 Nov 2002 09:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266581AbSKLONs>; Tue, 12 Nov 2002 09:13:48 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:1408 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S266578AbSKLONr>; Tue, 12 Nov 2002 09:13:47 -0500
Message-ID: <1094.80.127.241.140.1037110826.squirrel@keetweej.vanheusden.com>
Date: Tue, 12 Nov 2002 15:20:26 +0100 (CET)
Subject: Re: [PATCH] [RFC] increase MAX_ADDR_LEN
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1037111029.8321.12.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0211111808240.1236-100000@localhost.localdomain>
        <20021111.151929.31543489.davem@redhat.com>
        <52r8drn0jk.fsf_-_@topspin.com>
        <20021111.153845.69968013.davem@redhat.com>
        <1037060322.2887.76.camel@irongate.swansea.linux.org.uk>
        <52isz3mza0.fsf@topspin.com>
        <1037111029.8321.12.camel@irongate.swansea.linux.org.uk>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <roland@topspin.com>, <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Reply-To: folkert@vanheusden.com
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am I right that in net/ipv4/tcp_ipv4.c in function "tcp_v4_get_port" the
portnumber for a new connection is generated? Because fiddling with that
code seems to have no effect on the portnumbers generated for new
connections.


Folkert


