Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266530AbSKGNHw>; Thu, 7 Nov 2002 08:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266532AbSKGNHw>; Thu, 7 Nov 2002 08:07:52 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:10765 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S266530AbSKGNHv>; Thu, 7 Nov 2002 08:07:51 -0500
Date: Fri, 8 Nov 2002 00:14:12 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: bert hubert <ahu@ds9a.nl>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
       <lartc@mailman.ds9a.nl>
Subject: Re: IPSEC FIRST LIGHT! (by non-kernel developer :-))
In-Reply-To: <20021107130244.GA25032@outpost.ds9a.nl>
Message-ID: <Mutt.LNX.4.44.0211080012580.29718-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, bert hubert wrote:

> 	Use 3des-cbc
> 		examples online use blowfish-cbc but that gives an error
> 		in setkey

The kernel keying code doesn't know about blowfish yet, but it soon will.


- James
-- 
James Morris
<jmorris@intercode.com.au>


